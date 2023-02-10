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

## Tips

GitHub Pagesでのjekyllのの影響を考慮して`.nojekyll`ファイルをroot/docs/配下に作成しておく.

```{r}
# assume that you are in the root of the repository
file.create("docs/.nojekyll")
```
