![Logo](https://cdn.cottle.cloud/GitHub/LittleLink/littlelink.gif)

# LittleLink
DIY自托管的LinkTree替代方案。LittleLink拥有100多种品牌按钮样式，您可以轻松使用，社区会定期在此仓库和[LittleLink Extended](https://github.com/sethcottle/littlelink-extended)中添加更多样式。

---
### 🆕 LittleLink按钮生成器
想要为LittleLink制作自己的按钮，但不确定从何开始？[查看我们新的按钮生成器](https://builder.littlelink.io)。这个新工具可以让您预览按钮样式，一键复制生成的CSS代码到`css/brands.css`，并将生成的HTML代码复制到`index.html`。该生成器还通过检查对比度和在需要时建议描边来自动增强可访问性，确保您的自定义按钮在明暗主题下都能保持LittleLink的高可见性标准。可视化设计按钮，实时预览，随时准备使用代码。[在线网站](https://builder.littlelink.io) | [GitHub仓库](https://github.com/sethcottle/littlelink-button-builder)

---
### 🌞 主题与可访问性
LittleLink开箱即支持`auto`（自动）、`light`（浅色）和`dark`（深色）三种主题。如果默认配色方案不符合您的偏好，您可以通过更新`style.css`中的值轻松自定义。您可以直接在`index.html`中设置任何主题。为增强`浅色`和`深色`模式下的视觉可访问性，与背景对比度不足的按钮会添加反向描边以确保可见性。尽管LittleLink强调可访问性，但需要说明的是，并非所有集成的品牌按钮都能达到这一标准。品牌按钮始终保留品牌的原始特色，部分品牌按钮在对比度方面可能未达到最佳可访问性。

![主题](https://cdn.cottle.cloud/GitHub/LittleLink/ThemeSupport.gif)

---
### 🥇 性能

![性能](https://cdn.cottle.cloud/GitHub/LittleLink/ranking.gif)

LittleLink是简洁和极简主义的典范。当通过[Google PageSpeed Insights](https://pagespeed.web.dev/analysis/https-littlelink-io-sample-seth/17ex80ryq4?form_factor=mobile)等工具评估[LittleLink示例页面](https://littlelink.io/sample/seth)（该页面模拟了个人使用LittleLink的典型设置）时，LittleLink在性能、可访问性、最佳实践和SEO方面均获得100/100的优异成绩。我对LittleLink的最初愿景是从基础构建它。LittleLink使用自己的原生`css`，避免了使用大型框架带来的不必要冗余，因为这样一个简单页面根本不需要这些。

---
### ☁️ 部署

![发布](https://cdn.cottle.cloud/GitHub/LittleLink/test/css/deploy.gif)

无需gulp、npm或其他工具即可运行LittleLink——它仅使用最基本的资源。您可以通过下方按钮一键 fork 并部署到[Vercel](https://vercel.com/)、[Netlify](https://www.netlify.com/)或[Amplify](https://aws.amazon.com/amplify)。LittleLink也可以轻松通过[GitHub Pages](https://pages.github.com/)、家庭实验室服务器、CDN或其他前端托管服务进行部署。编辑时，您只需具备基本HTML知识即可添加链接到现有按钮，或创建自己的按钮。请参阅我们的[自定义按钮添加指南](https://github.com/sethcottle/littlelink/wiki/Adding-custom-buttons-to-your-own-fork)。真的很简单，放心尝试。 🤞

---
##### 一键部署

[![Deploy to Vercel](https://cdn.cottle.cloud/littlelink/button-deploy-vercel.svg)](https://vercel.com/new/clone?repository-url=https%3A%2F%2Fgithub.com%2Fsethcottle%2Flittlelink&project-name=littlelink&repository-name=littlelink)

[![Deploy to Netlify](https://cdn.cottle.cloud/littlelink/button-deploy-netlify.svg)](https://app.netlify.com/start/deploy?repository=https://github.com/sethcottle/littlelink)

[![Deploy to Amplify](https://cdn.cottle.cloud/littlelink/button-deploy-amplify.svg)](https://console.aws.amazon.com/amplify/home#/deploy?repo=https://github.com/sethcottle/littlelink)

---

### 🤝 Contributions
Please reference the [submitting a new brand to LittleLink wiki](https://github.com/sethcottle/littlelink/wiki/Submitting-a-new-brand-to-LittleLink) before opening a PR.

---
### 📦 Community Extras

#### 🛸 LittleLink Extended
Looking for more niche services to add to your copy of LittleLink? Check out [LittleLink Extended](https://github.com/sethcottle/littlelink-extended). Users can add more niche services to this repository to help keep the core LittleLink repository less cluttered and more focused on delivering branded experiences for the majority of users.

#### 🎨 Figma
Duplicate the [LittleLink Template on Figma Community](https://www.figma.com/community/file/846568099968305613) to help plan out and design your LittleLink page.

[![Figma Community](https://cdn.cottle.cloud/littlelink/button-figma-community.svg)](https://www.figma.com/community/file/846568099968305613)

#### 🐋 Docker
• [Techno Tim](https://github.com/timothystewart6) is building [LittleLink-Server](https://github.com/techno-tim/littlelink-server). Check out [his video](https://youtu.be/42SqfI_AjXU)!

• [Drew](https://github.com/davisdre) is building a [super simple Docker implementation of LittleLink](https://github.com/davisdre/littlelink).

#### 🗃️ Misc
• [Julian](https://github.com/JulianPrieber) is building [LinkStack](https://github.com/LinkStackOrg/LinkStack), which is a fork of [Khashayar](https://github.com/khashayarzavosh)'s [LittleLink Admin](https://github.com/khashayarzavosh/admin-littlelink).

---

### 💖 Supporters
You can support LittleLink by [buying me a coffee](https://www.buymeacoffee.com/seth). You can also have your name or your company added to this section and the supporters page of the [LittleLink.io](https://littlelink.io) website.

#### 🏢 Business Supporters
• **[Unallocated Space](https://connect.unallocatedspace.org/)** | Hacker/Makerspace in Millersville, MD, serving the greater Baltimore-Washington area

• **[links.dev](https://github.com/fatih-yavuz/links.dev)**

[![Add Your Company Name](https://cdn.cottle.cloud/littlelink/button-buy-me-a-coffee-company.svg)](https://www.buymeacoffee.com/seth/e/50574)

#### ✨ Individual Supporters
• **[Drew Davis](https://connect.davisdre.me)**

• **[Robotter112](https://robotter112.de/)**

[![Buy Me A Coffee](https://cdn.cottle.cloud/littlelink/button-buy-me-a-coffee-individual.svg)](https://www.buymeacoffee.com/seth/e/50573)

#### 🐙 Active GitHub Sponsors
• **[Your Name Here](https://github.com/sponsors/sethcottle)**

[![GitHub Sponsors](https://cdn.cottle.cloud/littlelink/button-github-sponsors.svg)](https://github.com/sponsors/sethcottle)


#### 🥰 More Ways to Support LittleLink
[![Buy Me A Coffee](https://cdn.cottle.cloud/littlelink/button-buy-me-a-coffee.svg)](https://www.buymeacoffee.com/seth/)

[![Ko-Fi](https://cdn.cottle.cloud/littlelink/button-ko-fi.svg)](https://ko-fi.com/sethcottle)

[![PayPal](https://cdn.cottle.cloud/littlelink/button-paypal.svg)](https://paypal.me/sethcottle/)

---

### 🆕 Stay Connected

Join the [Seth's Nook Discord](https://discord.gg/PrAEQFF2fK) server to get updates on LittleLink and more. Use the invite code `PrAEQFF2fK` or click the button below.

[![Discord](https://cdn.cottle.cloud/littlelink/button-discord.svg)](https://discord.gg/PrAEQFF2fK)

---

### 📊 Analytics

To help build a more privacy focused product, we recommend using [Fathom Analytics](https://usefathom.com/ref/EQVZMV)*. [View our Fathom analytics dashboard](https://app.usefathom.com/share/xbmnwxxl/littlelink.io#/?filters=%5B%5D&range=last_7_days&site=2251799827005303)**.

###### * This is a referral link. Using this link to sign up for Fathom is an easy way to help support LittleLink!

###### ** Analytics in this dashboard start May 03, 2022. View this [Google Sheets file](https://docs.google.com/spreadsheets/d/1GL4SroAdH-OZphBVR5z-BoSukHIEVJfao25q_e9-Ii8/edit?usp=sharing) with the generic unique pageview data from Google Analytics.

[![Fathom](https://cdn.cottle.cloud/littlelink/button-fathom-analytics.svg)](https://usefathom.com/ref/EQVZMV)

---
### 🐳 Docker Support
LittleLink includes Docker support for easy deployment and development. All Docker-related files are located in the `docker/` directory.

To run LittleLink using Docker:

```bash
docker compose -f docker/compose.yaml up
```

This will make the site available at http://localhost:8080

For more information about Docker configuration, see [docker/README.md](docker/README.md).

---
