#!/bin/bash

#=================================================
# COMMON VARIABLES
#=================================================

pnpm_version="11.21.0"
prisma_version="7.9.1"

#=================================================
# PERSONAL HELPERS
#=================================================

myynh_build() {

# Download, check integrity, uncompress and patch the source from manifest.toml
ynh_setup_source --dest_dir="$install_dir/build"

chown -R "$app:$app" "$install_dir/build"

ynh_config_add --template=".env" --destination="$install_dir/build/.env"

chmod 650 "$install_dir/build/.env"

corepack enable
ynh_hide_warnings npm install -g corepack@latest
ynh_hide_warnings ynh_exec_as_app corepack prepare pnpm@${pnpm_version} --activate

pushd "$install_dir/build"
	
	ynh_hide_warnings ynh_exec_as_app pnpm install --frozen-lockfile --os linux --libc glibc
	cp docker/proxy.ts src
	ynh_hide_warnings ynh_exec_as_app env NODE_ENV=production NEXT_TELEMETRY_DISABLED=1 DATABASE_URL="postgresql://$db_user:$db_pwd@localhost:5432/$db_name" npm run build-db
	ynh_hide_warnings ynh_exec_as_app env NODE_ENV=production NEXT_TELEMETRY_DISABLED=1 DATABASE_URL="postgresql://$db_user:$db_pwd@localhost:5432/$db_name" npm run build-tracker 
	ynh_hide_warnings ynh_exec_as_app env NODE_ENV=production NEXT_TELEMETRY_DISABLED=1 DATABASE_URL="postgresql://$db_user:$db_pwd@localhost:5432/$db_name" npm run build-recorder 
	ynh_hide_warnings ynh_exec_as_app env NODE_ENV=production NEXT_TELEMETRY_DISABLED=1 DATABASE_URL="postgresql://$db_user:$db_pwd@localhost:5432/$db_name" npm run build-geo
	ynh_hide_warnings ynh_exec_as_app env NODE_ENV=production NEXT_TELEMETRY_DISABLED=1 DATABASE_URL="postgresql://$db_user:$db_pwd@localhost:5432/$db_name" npm run build-app
	ynh_hide_warnings ynh_exec_as_app env NODE_ENV=production NEXT_TELEMETRY_DISABLED=1 DATABASE_URL="postgresql://$db_user:$db_pwd@localhost:5432/$db_name" npm run check-db
	ynh_hide_warnings ynh_exec_as_app env NODE_ENV=production NEXT_TELEMETRY_DISABLED=1 DATABASE_URL="postgresql://$db_user:$db_pwd@localhost:5432/$db_name" npm run update-tracker
	ynh_safe_rm "$install_dir/build/node_modules/"
	
	# Actual app is a subset of release assets
	# List of deps based on Dockerfile: https://github.com/umami-software/umami/blob/master/Dockerfile
	rsync -a --remove-source-files public .next/standalone/
	rsync -a --remove-source-files prisma .next/standalone/
    rsync -a --remove-source-files prisma.config.ts .next/standalone/
	rsync -a --remove-source-files scripts .next/standalone/
	rsync -a --remove-source-files generated .next/standalone/
	rsync -a --remove-source-files .next/static .next/standalone/.next/
popd

mkdir "$install_dir/release"
chmod -R o-rwx "$install_dir/release"
chown -R $app:$app "$install_dir/release"
pushd "$install_dir/release"
	ynh_exec_as_app echo {} > package.json
    ynh_exec_as_app printf "allowBuilds:\n  '@prisma/engines': true\n  prisma: false\nverifyDepsBeforeRun: false\n" > pnpm-workspace.yaml
    ynh_hide_warnings ynh_exec_as_app env NODE_ENV=production NEXT_TELEMETRY_DISABLED=1 pnpm add npm-run-all dotenv chalk semver \
        prisma@${prisma_version} \
        @prisma/client@${prisma_version} \
        @prisma/adapter-pg@${prisma_version}
popd

rsync -a --remove-source-files  $install_dir/build/.next/standalone/ $install_dir/release


ynh_safe_rm "$install_dir/.cache"
ynh_safe_rm "$install_dir/.npm"
ynh_safe_rm "$install_dir/.local"

ynh_safe_rm "$install_dir/build"
}
