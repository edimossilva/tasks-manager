import React, { Component } from 'react';

class Login extends Component {
  render() {
    return (
      <div>
        <label name="username">Username:</label>
        <input type="text" name="username" />

        <label name="password">Passwor:</label>
        <input type="password" name="password" />

        <button type="submit">Login :)</button>
      </div>
    );
  }
}

export default Login;
