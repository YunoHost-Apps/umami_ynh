<!--
注意：此 README 由 <https://github.com/YunoHost/apps/tree/master/tools/readme_generator> 自动生成
请勿手动编辑。
-->

# YunoHost 上的 Umami

[![集成程度](https://dash.yunohost.org/integration/umami.svg)](https://ci-apps.yunohost.org/ci/apps/umami/) ![工作状态](https://ci-apps.yunohost.org/ci/badges/umami.status.svg) ![维护状态](https://ci-apps.yunohost.org/ci/badges/umami.maintain.svg)

[![使用 YunoHost 安装 Umami](https://install-app.yunohost.org/install-with-yunohost.svg)](https://install-app.yunohost.org/?app=umami)

*[阅读此 README 的其它语言版本。](./ALL_README.md)*

> *通过此软件包，您可以在 YunoHost 服务器上快速、简单地安装 Umami。*  
> *如果您还没有 YunoHost，请参阅[指南](https://yunohost.org/install)了解如何安装它。*

## 概况

Umami is a simple, easy to use, self-hosted web analytics solution. The goal is to provide you with a friendlier, privacy-focused alternative to Google Analytics and a free, open-sourced alternative to paid solutions. Umami collects only the metrics you care about and everything fits on a single page. 

### Features

- Simple analytics
- Unlimited websites
- Bypass ad-blockers
- Light-weight
- Multiple accounts
- Share data
- Mobile-friendly
- Data ownership
- Privacy-focused


**分发版本：** 2.12.1~ynh1

**演示：** <https://app.umami.is/share/8rmHaheU/umami.is>

## 截图

![Umami 的截图](./doc/screenshots/dark.png)

## 文档与资源

- 官方应用网站： <https://umami.is/>
- 官方管理文档： <https://umami.is/docs/about>
- 上游应用代码库： <https://github.com/mikecao/umami>
- YunoHost 商店： <https://apps.yunohost.org/app/umami>
- 报告 bug： <https://github.com/YunoHost-Apps/umami_ynh/issues>

## 开发者信息

请向 [`testing` 分支](https://github.com/YunoHost-Apps/umami_ynh/tree/testing) 发送拉取请求。

如要尝试 `testing` 分支，请这样操作：

```bash
sudo yunohost app install https://github.com/YunoHost-Apps/umami_ynh/tree/testing --debug
或
sudo yunohost app upgrade umami -u https://github.com/YunoHost-Apps/umami_ynh/tree/testing --debug
```

**有关应用打包的更多信息：** <https://yunohost.org/packaging_apps>
