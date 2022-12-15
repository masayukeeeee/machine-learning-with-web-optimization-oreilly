# Machine-learning-with-web-optimization-oreilly
ウェブ最適化ではじめる機械学習のR実装

Goal : Rで実装してGithub pagesで公開する

# Management

- 'main' ブランチにプッシュされた時にサイトを公開する

## Rendering

`./docs`配下にレンダリングされたファイルを配置する

```{r}
bookdown::render_book("book", output_dir="../docs")
```