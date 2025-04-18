package com.vfi.smartpos.deviceservice.aidl;

import com.vfi.smartpos.deviceservice.aidl.ScannerListener;

/**
 * \cn_
 * @brief 扫码器对象
 *
 * 实现设备对二维码扫码功能。
 * \_en_
 * @brief the object of scanner
 *
 * for scanning the bar-code or QR-code
 * \en_e
 * \code{.java}
 * \endcode
 * @version
 * @see
 *
 * @author: baoxl
 */
interface IScanner {
	/**
     * en_
     * @brief start scan
     *
	 * @param param
     *  <BR>topTitleString(String) the title string on the top, align center.
     *  <BR>upPromptString(String) the prompt string upside of the scan box, align center.
     *  <BR>downPromptString(String) the prompt string downside of the scan box , align center.
	 *  <BR>showScannerBorder(boolean, true is default) false for: scanner border & upPromptString &downPromptString will be hided,
	 *  <BR>scannerSelect(int) 0 for front, 1 for rear(if not set this paramater, use IDeviceService.getScanner() to set front/rear position)
	 * @param timeout  the timeout, millsecond.
	 * @param  listener  the call back listerner
     * \en_e
     * \code{.java}
     * \endcode
     * @version
     * @see
     *
	 *
	 */
	void startScan(in Bundle param, long timeout, ScannerListener listener);
	
	/**
     * \cn_
     * @brief 停止扫码
     *
     * \_en_
     * @brief stop scan
     *
     * \en_e
     * \code{.java}
     * \endcode
     * @version
     * @see
     *
	 *
	 */
	void stopScan();
}