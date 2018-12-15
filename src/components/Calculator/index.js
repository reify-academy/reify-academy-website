const Elm = require("react-elm-components");
var CalculatorElm = require("./src/Main.elm");
const React = require("react");

const CalculatorComponent = () => (
  <Elm
    src={CalculatorElm.Elm.Main}
    flags={{ totalNumberOfHours: 480, costPerMonth: 1800 }}
  />
);
export default CalculatorComponent;
