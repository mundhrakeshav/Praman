import React, { useState } from "react";
import "./UserLoginpage.css";

const UserLoginSignUpPage = () => {
  const [isLoginpage, togglePage] = useState(true);

  return (
    <>
      <nav className="navbar navbar-expand-lg navbar-dark ">
        <div className="container-fluid">
          <a className="navbar-brand" href="#">
            प्रमाण
          </a>
          <button
            className="navbar-toggler"
            type="button"
            data-toggle="collapse"
            data-target="#navbarNav"
            aria-controls="navbarNav"
            aria-expanded="false"
            aria-label="Toggle navigation"
          >
            <span className="navbar-toggler-icon"></span>
          </button>
          <div className="collapse navbar-collapse" id="navbarNav">
            <ul className="navbar-nav ml-auto">
              <li
                className="nav-item"
                onClick={() => {
                  isLoginpage ? togglePage(false) : togglePage(true);
                }}
              >
                <a className="nav-link" href="#">
                  {!isLoginpage ? "Login" : "Register"}
                </a>
              </li>
              <li className="nav-item">
                <a className="nav-link" href="#">
                  Certifier?
                </a>
              </li>
            </ul>
          </div>
        </div>
      </nav>
      <div className="login-box">
        <form>
          <div className="user-box">
            <input type="number" name="" required="" />
            <label>UID Number</label>
          </div>
          <div className="user-box">
            <input type="password" name="" required="" />
            <label>Password</label>
          </div>
          <a href="#">
            <span></span>
            <span></span>
            <span></span>
            <span></span>
            {isLoginpage ? "Login" : "Register"}
          </a>
        </form>
      </div>
    </>
  );
};

export default UserLoginSignUpPage;
