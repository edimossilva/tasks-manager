import React, { Component } from 'react';
import { Container, FormItem } from './styles';

class Login extends Component {
  render() {
    return (
      <Container>
        <FormItem>
          <input type="text" name="username" placeholder="login" />
        </FormItem>

        <FormItem>
          <input type="password" name="password" placeholder="password" />
        </FormItem>

        <button type="submit">Log in </button>
      </Container>
    );
  }
}

export default Login;
