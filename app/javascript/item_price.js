function price(){
  const priceInput = document.getElementById("item-price");
 
 if (priceInput) { 
   priceInput.addEventListener("input", () => {
     const addTaxDom = document.getElementById("add-tax-price");
     if (addTaxDom) {
      
     addTaxDom.innerHTML = Math.floor(priceInput.value * 0.1 );
    }
     const addProfitDom = document.getElementById("profit");
     if (addProfitDom) {
      
     addProfitDom.innerHTML = Math.floor(priceInput.value - Math.floor(priceInput.value * 0.1 ))
    }
  });
}
};

window.addEventListener('turbo:load', price);
window.addEventListener('turbo:render', price);