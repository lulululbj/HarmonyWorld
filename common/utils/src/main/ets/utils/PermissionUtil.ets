import { abilityAccessCtrl, Permissions } from '@kit.AbilityKit'

export async function checkAndRequestPermission(context: Context, permissionList: Permissions[]): Promise<boolean> {
  let grantedAll = true
  let grantStatus: number[] = await requestPermission(context, permissionList)
  for (let index = 0; index < grantStatus.length; index++) {
    if (grantStatus[index] === abilityAccessCtrl.GrantStatus.PERMISSION_DENIED) {
      grantedAll = false
    }
  }
  return Promise.resolve(grantedAll)
}

async function requestPermission(context: Context, permissionList: Permissions[]): Promise<number[]> {
  let requestResult = await abilityAccessCtrl.createAtManager().requestPermissionsFromUser(context, permissionList)
  return requestResult.authResults
}