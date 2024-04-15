import CommonUtilTest from './CommonUtil.test'
import localUnitTest from './LocalUnit.test';

export default function testsuite() {
  localUnitTest();
  CommonUtilTest()
}