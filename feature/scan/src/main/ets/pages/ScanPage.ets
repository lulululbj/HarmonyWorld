import { NormalButton, TitleComponent } from '@ohos/components/Index'
import { detectBarcode, scanBarcode, scanCore } from '@kit.ScanKit'
import { Log, NavigationManager } from '@ohos/utils/Index'
import { picker } from '@kit.CoreFileKit'

@Component
export struct ScanPage {
  @State scanResult: string = ""

  build() {
    Column() {

      TitleComponent({
        title: "Scan Kit",
        leftClick: () => {
          NavigationManager.getInstance().pop()
        }
      })

      TextInput({
        text: this.scanResult
      }).enableKeyboardOnFocus(false)

      NormalButton({
        text: "默认扫码",
        click: () => {
          let options: scanBarcode.ScanOptions = {
            scanTypes: [scanCore.ScanType.ALL],
            enableMultiMode: true,
            enableAlbum: true
          }
          try {
            scanBarcode.startScanForResult(getContext(this), options)
              .then((result) => {
                this.scanResult = `${result.scanType} ${result.originalValue}`
              })
          } catch (e) {
            Log.error("默认扫描", "error: " + JSON.stringify(e))
          }
        }
      })

      NormalButton({
        text: "自定义扫码",
        click: () => {
          NavigationManager.getInstance().pushPathByName("CustomScanPage")
        }
      })

      NormalButton({
        text: "相册选取",
        click: () => {
          let options: scanBarcode.ScanOptions = {
            scanTypes: [scanCore.ScanType.ALL],
            enableMultiMode: true,
            enableAlbum: true
          }
          let photoOption = new picker.PhotoSelectOptions()
          photoOption.MIMEType = picker.PhotoViewMIMETypes.IMAGE_TYPE
          photoOption.maxSelectNumber = 1
          let photoPicker = new picker.PhotoViewPicker()
          photoPicker.select(photoOption)
            .then((result) => {
              let inputImage: detectBarcode.InputImage = { uri: result.photoUris[0] }
              detectBarcode.decode(inputImage, options,).then((result: Array<scanBarcode.ScanResult>) => {
                if (result.length > 0) {
                  this.scanResult = result[0].originalValue
                }
              }).catch((err: Error) => {
                Log.error("ScanPage", "decode image error: " + JSON.stringify(err))
              })
            })
        }
      })
    }
  }
}