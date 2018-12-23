import React from "react";

const MultilineParagraph = ({ text }) =>
  text.split("\n").map(paragraph => <p>{paragraph}</p>);

export default MultilineParagraph;
