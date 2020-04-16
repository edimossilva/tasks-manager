import styled from 'styled-components';

export const Container = styled.div`
  background: #fff;
  border-radius: 4px;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  padding: 30px;
  width: 400px;

  button[type='submit'] {
    background-color: #3fc5f0;
    border: none;
    color: white;
    padding: 15px 32px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    text-transform: uppercase;
    font-size: 13px;
    box-shadow: 0 10px 30px 0 rgba(95, 186, 233, 0.4);
    border-radius: 5px 5px 5px 5px;
    width: 50%;
    margin: 5px;
  }
`;

export const FormItem = styled.div`
  display: flex;
  flex-direction: row;
  justify-content: center;

  input[type='text'],
  input[type='password'] {
    background-color: #f6f6f6;
    border: none;
    color: #0d0d0d;
    padding: 15px 32px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
    margin: 5px;
    width: 100%;
    border: 2px solid #f6f6f6;
    border-radius: 5px 5px 5px 5px;
  }
`;
