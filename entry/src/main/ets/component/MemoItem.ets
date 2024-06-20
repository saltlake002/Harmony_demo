import MemoModel from '../model/MemoModel'

interface TimeFormat {
  range: string
  formatDate: string
  formatTime: string
}

function getFormatTime(timeStamp: number): TimeFormat {
  const today = new Date();
  const date = new Date(timeStamp);
  date.toLocaleString()
  // 计算日期差值
  const diffTime = today.getTime() - date.getTime();
  // 向下取整
  const diffDays = Math.floor(diffTime / (24 * 60 * 60 * 1000));

  let range: string = ''

  if (diffDays === 0) {
    range = '今天'
  } else if (diffDays === 1) {
    range = '昨天'
  } else if (diffDays === 2) {
    range = '前天'
  } else {
    range = '三天前'
  }

  const month: string = (date.getMonth() + 1).toString().padStart(2, '0')
  const day: string = date.getDate().toString().padStart(2, '0')
  const hours: string = date.getHours().toString().padStart(2, '0')
  const minute: string = date.getMinutes().toString().padStart(2, '0')

  const formatDate: string = `${month}月${day}日`
  const formatTime: string = `${hours}:${minute}`

  return { range, formatDate, formatTime }

}

@Component
export default struct MemoItem {
  @ObjectLink memo: MemoModel
  onMemoClick :(memo:MemoModel)=>void

  build() {
    Row() {
      Stack() {
        Row() {
          // 左侧
          // Column() {
          //
          // }
          // .width(26)
          // .height(90)
          // .borderRadius({ topLeft: 4, bottomLeft: 4 })

          // 右侧
          Column() {

            Column() {
              Text(this.memo.content)
                .fontColor('#292421')
                .maxLines(2)
                .margin({ right: 20 })
            }
            .margin({ left: 20 })
            .justifyContent(FlexAlign.Center)
            .height(64)

            Row() {
              Text(getFormatTime(this.memo.updateTime).range)
                .fontSize(12).fontColor('#808A87')
              Text(getFormatTime(this.memo.updateTime).formatDate)
                .fontSize(12).fontColor('#808A87')
              Text(getFormatTime(this.memo.updateTime).formatTime)
                .fontSize(12).fontColor('#808A87')
            }
            .margin({ left: 20 })
            .height(25)
            .position({x : '70%', y : '70%'})

          }
          .alignItems(HorizontalAlign.Start)
          .height(90)
          .borderRadius({ topRight: 4, bottomRight: 4 })
          .margin({ right: 27 })

        }
      }
      .width('100%')
      .alignContent(Alignment.Start)
      .onClick(()=>{
        this.onMemoClick(this.memo)
      })
      .backgroundColor('#fefefc')
      .borderRadius('20')

    }
    .margin({top:12})
    .padding({left:20,right:20})


  }
}
