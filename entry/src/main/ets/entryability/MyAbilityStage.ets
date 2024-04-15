import { AbilityStage, common, Want } from '@kit.AbilityKit';
import { Log } from '@ohos/utils/Index';

export class MyAbilityStage extends AbilityStage {
  onCreate() {
    console.log('MyAbilityStage.onCreate is called');
    // let want: Want = {
    //   bundleName: "luyao.harmonyworld",
    //   abilityName: "EntryAbility"
    // }
    // let context = getContext() as common.UIAbilityContext
    // context.startAbility(want)
    //   .catch((err: Error) => {
    //     Log.error("stage",JSON.stringify(err))
    //   })
  }
}