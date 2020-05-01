/// <reference types="cypress" />

context("Login", () => {
  const invalidUsername = "invalid username";
  const invalidPassword = "invalid password";

  beforeEach(() => {
    localStorage.clear();
    cy.visit("http://localhost:4200");
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
      cy.wait(2000);
      cy.url().then((currentUrl) =>
        expect(currentUrl).to.equal("http://localhost:4200/login")
      );
    });
  });

  describe("When use correct credentials", () => {
    it("login works and redirect to homepage", () => {
      // fill username
      cy.get(".login__input-username")
        .type("registered_user1")
        .should("have.value", "registered_user1");

      // fill password
      cy.get(".login__input-password").type("111").should("have.value", "111");

      // click login
      cy.get(".login__button-login").click();

      // wait login request
      cy.wait(1000);

      cy.url().then((currentUrl) =>
        expect(currentUrl).to.equal("http://localhost:4200/tasklists")
      );
    });
  });
});
