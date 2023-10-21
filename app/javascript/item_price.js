window.addEventListener('load', () => {
  const priceInput = document.getElementById("item-price");
 //  console.log(priceInput)
   priceInput.addEventListener("input", () => {
     const addTaxDom = document.getElementById("add-tax-price");
     // console.log(priceInput.innerHTML);
     addTaxDom.innerHTML = Math.floor(priceInput.value * 0.1 );
     const addProfitDom = document.getElementById("profit");
     // console.log(priceInput.innerHTML);
     addProfitDom.innerHTML = Math.floor(priceInput.value - Math.floor(priceInput.value * 0.1 ))
 })
});