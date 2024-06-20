


@Component
export default struct CustomTitle {
  @Link order: boolean
  @Link isAddDialogShow: boolean

  // 重用样式 @Styles
  @Styles
  titleButtonStyle(){
    .width(56)
    .height(32)
  }


  build() {

    Row() {

      // 标题
      Text('Memo')
        .fontColor('#292421')
        .fontSize('36')
        .fontWeight(600)
        .margin({left : 30})

      // 排序
      Column() {
        if (this.order) {
          Image($r('app.media.up1'))
            .width(16)
        } else {
          Image($r('app.media.down1'))
            .width(16)
        }
      }
      .titleButtonStyle()
      .justifyContent(FlexAlign.Center)
      .margin({ left: 10 })
      .onClick(() => {
        this.order = !this.order
      })


      // 新建笔记
      Column() {
        Image($r('app.media.eedit'))
          .width(16)
      }
      .titleButtonStyle()
      .justifyContent(FlexAlign.Center)
      .margin({ right: 10 })
      .onClick(() => {
        this.isAddDialogShow = true
      })

    }
    .width('100%')
    .height(200)
    .padding({top : 100})

  }
}
