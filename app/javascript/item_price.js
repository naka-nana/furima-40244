document.addEventListener('DOMContentLoaded', function(){
  // 価格入力フィールドの要素を取得
  const priceInput = document.getElementById("item-price");

  // 価格入力フィールドの値が変更されたときのイベントリスナーを設定
  priceInput.addEventListener("input", () => {
    const price = parseInt(priceInput.value); // 入力された価格を整数で取得

    // 販売手数料（10%とする）を計算し、小数点以下を切り捨てる
    const tax = Math.floor(price * 0.1);

    // 販売利益を計算（価格から手数料を引いたもの）
    const profit = Math.floor(price - tax);

    // 計算結果を対応するHTML要素に表示
    document.getElementById("add-tax-price").textContent = tax; // 手数料を表示
    document.getElementById("profit").textContent = profit; // 利益を表示
  });
});