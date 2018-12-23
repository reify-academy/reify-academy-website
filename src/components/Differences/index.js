import React from "react";
import PropTypes from "prop-types";
import MultilineParagraph from "../MultilineParagraph";

const Differences = ({ differences }) => (
  <div className="level columns">
    {(differences || []).map((difference, id) => (
      <div className="column level-item has-text-centered">
        <div>
          <p className="heading">{difference.title}</p>
          <MultilineParagraph text={difference.text} />
          <img src={difference.icon} />
        </div>
      </div>
    ))}
  </div>
);

Differences.propTypes = {
  differences: PropTypes.arrayOf(
    PropTypes.shape({
      title: PropTypes.string,
      icon: PropTypes.string,
      text: PropTypes.string,
    }),
  ),
};

export default Differences;
