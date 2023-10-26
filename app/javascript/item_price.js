window.addEventListener('load', () => {
  const priceInput = document.getElementById("item-price");
 //  console.log(priceInput)
 if (priceInput) { 
   priceInput.addEventListener("input", () => {
     const addTaxDom = document.getElementById("add-tax-price");
     if (addTaxDom) {
      // console.log(priceInput.innerHTML);
     addTaxDom.innerHTML = Math.floor(priceInput.value * 0.1 );
    }
     const addProfitDom = document.getElementById("profit");
     if (addProfitDom) {
      // console.log(priceInput.innerHTML);
     addProfitDom.innerHTML = Math.floor(priceInput.value - Math.floor(priceInput.value * 0.1 ))
    }
  });
}
});