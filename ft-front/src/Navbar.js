// Navbar.js

import React from 'react';
import { ReactComponent as SearchIcon } from './loupe.svg';
import './Navbar.css';

function Navbar() {
  return (
      <nav className="navbar">
        <div className="navbar-container">
          <ul className="navbar-items">
            <img className={'logo'} alt={'logo'} src={'img.png'}></img>
              <SearchIcon className="search-icon" />
              <li className="nav-item" data-text="EVENTS">EVENTS</li>
              <li className="nav-item" data-text="BROWSE BY CATEGORY">BROWSE BY CATEGORY</li>
              <li className="nav-item" data-text="EVENT ORGANIZER">EVENT ORGANIZER</li>
          </ul>
          <div className="login-button">
            <button>Login / Register</button>
          </div>
        </div>
      </nav>
  );
}

export default Navbar;
