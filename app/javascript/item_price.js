
const priceInput = document.getElementById("item-price");
priceInput.addEventListener("input", () => {
  const inputValue = priceInput.value;
})
const addTaxDom = document.getElementById("add-tax-price");
const profitDom = document.getElementById("profit");

priceInput.addEventListener("input", () => {
  const inputValue = priceInput.value;
  
  const tax = parseFloat(inputValue) * 0.1;
  const profit = parseFloat(inputValue) - tax;
  
  addTaxDom.innerHTML = tax;
  profitDom.textContent = profit;
});