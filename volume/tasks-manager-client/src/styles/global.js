import { createGlobalStyle } from 'styled-components';
export default createGlobalStyle`
  * {
    margin: 0;
    padding: 0;
    outline: 0;
    box-sizing: border-box;
  }

  html, body, #root {
    background: #3fc5f0;
    font-size: 14px Roboto, sans-serif;
    min-height: 100%;
    display:flex;
    justify-content:center;
    align-items:center;
  }

  #root {
    max-width: 1020px;
    margin: 0 auto;
    padding: 0 20px 50px;
  }
`;
