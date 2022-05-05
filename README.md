# Versawriter_Prototype Picture forming tool

## Helper tool for Hand-held Versawriter 
This is helper tool for Versa Writer using M5Atom matrix or M5Stick-C ( https://github.com/thorv/Versawriter_main )  
Picture forming tool by 'Processing Ver 3.5.4' ( https://processing.org )

## Overview
Since the versa writer swings in a fan shape or a circle, if normal image data is given to the LED column, the inner circumference side of the circle will be drawn smaller and the outer circumference side will be drawn larger. , Transforms the image so that it appears in its original shape on the Versa Writer. Also, change the number of vertical (LED arrangement direction) pixels of the image to the number of LEDs.

Open Arctool.pde in the Processing IDE and press the Run button to launch it.
Drop the image file you want to display in the window.
Adjust the size of the image with the mouse wheel and the position by dragging the image.

Use the buttons and sliders in the center of the window to set the orientation of the image and the range in which the versa writer is shaken.

On the right side of the window, an image that simulates the display on the Versa Writer is displayed.
It is assumed that 72 LEDs are lined up in a range of 50 cm. Also, the LED refresh rate is assumed to be 2.3ms.

Save the image created by pressing the SAVE button. The image format is specified by the extension.
Formats supported by Processing such as .jpg, .bmp, .png can be used.

## 概要
バーサライタは扇形または円形に振るため、LEDの列に通常の画像データを与えると円の内周側は小さく、外周側は大きく描画されることになります。これを補正して、バーサライタ上で概ねもとの形状で表示されるように画像を変形します。また、LEDの数に画像の縦(LEDの並び方向)画素数を変更します。

Processing IDEでArctool.pdeを開き、実行ボタンを押すと起動します。
表示したい画像ファイルをウインドウにドロップしてください。
マウスホイールで画像のサイズを、画像をドラッグすることで位置を調整します。

中央のボタンやスライダーで画像の向きやバーサライタの振る範囲などを設定します。

ウインドウ右側に、バーサライタでの表示をシミュレートした画像を表示します。
LEDは72個が50cmの範囲に並んでいることを前提としています。また、LEDのリフレッシュレートは2.3msを想定しています。

SAVEボタンを押すことで作成した画像を保存します。画像フォーマットは拡張子で指定します。
.jpg, .bmp, .png等、Processingが対応するフォーマットが使用できます。
