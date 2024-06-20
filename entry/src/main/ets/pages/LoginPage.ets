/*
 * Copyright (c) 2022 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import prompt from '@ohos.promptAction';
import router from '@ohos.router';



@Extend(TextInput)
function inputStyle() {
  .placeholderColor($r('app.color.placeholder_color'))
  .height($r('app.float.login_input_height'))
  .fontSize($r('app.float.big_text_size'))
  .backgroundColor($r('app.color.background'))
  .width("100%")
  .padding({ left: 0})
  .margin({ top: $r('app.float.input_margin_top') })
}

@Extend(Line)
function lineStyle() {
  .width("100%")
  .height($r('app.float.line_height'))
  .backgroundColor($r('app.color.line_color'))
}

@Extend(Text)
function blackTextStyle() {
  .fontColor('#0d0c22')
  .fontSize($r('app.float.small_text_size'))
  .fontWeight(FontWeight.Medium)
}

/**
 * Login page
 */
@Entry
@Component
struct LoginPage {
  @State account: string = 'admin';
  @State password: string = '12345';
  @State isShowProgress: boolean = false;
  private timeOutId: number = -1;

  @Builder
  imageButton(src: Resource) {
    Button({ type: ButtonType.Circle, stateEffect: true }) {
      Image(src)
    }
    .height($r('app.float.other_login_image_size'))
    .width($r('app.float.other_login_image_size'))
    .backgroundColor($r('app.color.background'))
  }

  login(): void {
    if (this.account === '' || this.password === '') {
      prompt.showToast({
        message: $r('app.string.input_empty_tips')
      })
    } else {
      this.isShowProgress = true;
      if (this.timeOutId === -1) {
        this.timeOutId = setTimeout(() => {
          this.isShowProgress = false;
          this.timeOutId = -1;
          router.replaceUrl({ url: 'pages/Index' });
        }, 2000);
      }
    }
  }

  aboutToDisappear() {
    clearTimeout(this.timeOutId);
    this.timeOutId = -1;
  }

  build() {
    Column() {

      Text($r('app.string.login_page'))
        .fontSize($r('app.float.title_text_size_max'))
        .fontWeight(FontWeight.Medium)
        .fontColor($r('app.color.title_text_color'))
        .margin({top : 160 ,bottom : 80})

      TextInput({ placeholder: $r('app.string.account') , text:this.account})
        .maxLength(11)
        .type(InputType.Number)
        .inputStyle()
        .padding('30px')
        .backgroundColor('#f8f8f8')
        .onChange((value: string) => {
          this.account = value;
        })


      TextInput({ placeholder: $r('app.string.password') })
        .maxLength(8)
        .type(InputType.Password)
        .inputStyle()
        .padding('30px')
        .backgroundColor('#f8f8f8')
        .onChange((value: string) => {
          this.password = value;
        })


      Row() {
        Text($r('app.string.message_login')).blackTextStyle()
        Text($r('app.string.forgot_password')).blackTextStyle()
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width('100%')
      .margin({ top: $r('app.float.forgot_margin_top') })

      Button($r('app.string.login'), { type: ButtonType.Capsule })
        .width("90%")
        .height($r('app.float.login_button_height'))
        .fontSize($r('app.float.normal_text_size'))
        .fontWeight(FontWeight.Medium)
        .backgroundColor('#0d0c22')
        .margin({ top: $r('app.float.login_button_margin_top'), bottom: $r('app.float.login_button_margin_bottom') })
        .onClick(() => {
          this.login();
        })
      Text($r('app.string.register_account'))
        .fontColor('#0d0c22')
        .fontSize($r('app.float.normal_text_size'))
        .fontWeight(FontWeight.Medium)

      if (this.isShowProgress) {
        LoadingProgress()
          .color($r('app.color.loading_color'))
          .width($r('app.float.login_progress_size'))
          .height($r('app.float.login_progress_size'))
          .margin({ top: $r('app.float.login_progress_margin_top') })
      }

      //其他登录方式
      // Blank()
      // Text($r('app.string.other_login_method'))
      //   .fontColor($r('app.color.other_login_text_color'))
      //   .fontSize($r('app.float.little_text_size'))
      //   .fontWeight(FontWeight.Medium)
      //   .margin({ top: $r('app.float.other_login_margin_top'), bottom: $r('app.float.other_login_margin_bottom') })
      // Row({ space: CommonConstants.LOGIN_METHODS_SPACE }) {
      //   this.imageButton($r('app.media.login_method1'))
      //   this.imageButton($r('app.media.login_method2'))
      //   this.imageButton($r('app.media.login_method3'))
      // }
    }
    .backgroundColor($r('app.color.background'))
    .height("100%")
    .width("100%")
    .padding({
      left: $r('app.float.page_padding_hor'),
      right: $r('app.float.page_padding_hor'),
      bottom: $r('app.float.login_page_padding_bottom')
    })
  }
}