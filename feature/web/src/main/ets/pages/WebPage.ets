import { TitleComponent } from '@ohos/components/Index'
import { webview } from '@kit.ArkWeb'
import { Log, NavigationManager } from '@ohos/utils/Index'
import { AndroidProxy } from './AndroidProxy'
import { picker } from '@kit.CoreFileKit'
import { BusinessError } from '@kit.BasicServicesKit'

const TAG = "WebPage"

@Component
export struct WebPage {
  @State title: string = ""
  controller: WebviewController = new webview.WebviewController()
  androidProxy = new AndroidProxy()

  build() {
    Column() {
      TitleComponent({
        title: this.title,
        onBack: () => {
          if (this.controller.accessBackward()) {
            this.controller.backward()
          } else {
            NavigationManager.getInstance().pop()
          }
        }
      })

      Web({
        src: $rawfile('demo.html'),
        controller: this.controller
      })
        .javaScriptAccess(true)
        .javaScriptProxy({
          object: this.androidProxy,
          name: "jsBridge",
          methodList: ["webCallNative"],
          controller: this.controller
        })
        .onTitleReceive((event) => {
          if (event) {
            this.title = event.title
          }
        })
        .onProgressChange((event) => {
          if (event) {
            let progress = event.newProgress
          }
        })
        .onPageEnd(() => {

        })
        .onInterceptRequest((event) => {
          if (event) {

          }
          return null
        })
        .onControllerAttached(() => {
          // 推荐在此注入 JS 对象
        })
        .onShowFileSelector((event) => {
          // 文件选择
          const documentSelectOptions = new picker.DocumentSelectOptions();
          let uri: string | null = null;
          const documentViewPicker = new picker.DocumentViewPicker();
          documentViewPicker.select(documentSelectOptions).then((documentSelectResult) => {
            uri = documentSelectResult[0];
            Log.info(TAG, 'documentViewPicker.select to file succeed and uri is:' + uri);
            if (event) {
              event.result.handleFileList([uri]);
            }
          }).catch((err: BusinessError) => {
            Log.error(TAG, `Invoke documentViewPicker.select failed, code is ${err.code}, message is ${err.message}`);
          })
          return true
        })
    }
  }
}