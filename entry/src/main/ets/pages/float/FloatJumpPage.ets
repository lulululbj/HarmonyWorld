@Entry
@Component
struct FloatJumpPage {
  @State message: string = 'Welcome to HarmonyOS World!';

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
    }
    .height('100%')
  }
}