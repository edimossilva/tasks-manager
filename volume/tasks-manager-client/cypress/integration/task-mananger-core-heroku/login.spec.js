/// <reference types="cypress" />

context("Login", () => {
  const invalidUsername = "invalid username";
  const invalidPassword = "invalid password";
  const base_url = "http://localhost:4200/";
  beforeEach(() => {
    localStorage.clear();
    cy.visit("/");
    cy.get(".login__input-username").clear();
    cy.get(".login__input-password").clear();
  });

  describe("When use wrong credentials", () => {
    it("login fails and does not redirect to homepage", () => {
      // fill username
      cy.get(".login__input-username")
        .type(invalidUsername)
        .should("have.value", invalidUsername);
      // // fill password
      cy.get(".login__input-password")
        .type(invalidPassword)
        .should("have.value", invalidPassword);
      // // click login
      cy.get(".login__button-login").click();
      // // wait login request
      // cy.wait(1000);
      cy.url().then((currentUrl) =>
        expect(currentUrl).to.equal(`${base_url}login`)
      );
    });
  });

  describe("When use correct credentials", () => {
    it("login works and redirect to homepage", () => {
      const userName = "test_user";
      const password = "111";
      // fill username
      cy.get(".login__input-username")
        .type(userName)
        .should("have.value", userName);

      // fill password
      cy.get(".login__input-password")
        .type(password)
        .should("have.value", password);

      // click login
      cy.get(".login__button-login").click();

      // wait login request
      cy.wait(1000);

      cy.url().then((currentUrl) =>
        expect(currentUrl).to.equal(`${base_url}tasklists`)
      );
    });
  });
});
