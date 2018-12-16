import React from "react";
import PropTypes from "prop-types";

const Differences = ({ differences }) => (
  <div className="level columns">
    {(differences || []).map((difference, id) => (
      <div className="column level-item has-text-centered">
        <div>
          <p className="heading">{difference.title}</p>
          <p>{difference.text}</p>
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
