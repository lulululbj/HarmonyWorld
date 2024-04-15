import { afterAll, afterEach, beforeAll, beforeEach, describe, it } from '@ohos/hypium'
import { sleep } from '../main/ets/utils/CommonUtil'

export default function CommonUtilTest() {
  describe('CommonUtilTest', () => {
    // Defines a test suite. Two parameters are supported: test suite name and test suite function.
    beforeAll(() => {
      console.log("start")
    })
    it('sleep', 0, async () => {
      await sleep(1000)
      console.log("end")
    })
  })
}