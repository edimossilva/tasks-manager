/// <reference types="cypress" />

context("Create TaskList", () => {
  const name = `name ${Date.now()}`;
  const description = `description ${Date.now()}`;
  const base_url = "http://localhost:4200/";
  const tasklistsUrl = "http://localhost:4200/tasklists";

  beforeEach(() => {
    // localStorage.clear();
    cy.visit(base_url);
    cy.get(".login__input-username").clear();
    cy.get(".login__input-password").clear();
    cy.get(".login__input-username").type("registered_user2");
    cy.get(".login__input-password").type("222");
    cy.get(".login__button-login").click();

    // cy.wait(2000);
  });

  describe("When data is valid", () => {
    it("creates TaskList ", () => {
      cy.get(".tasklist-create__button").click();
      // cy.visit(tasklistsUrl);
      console.log(cy.get(".tasklist-create__button"));
      // click to open create task dialog
      // fill data
      cy.get(".tasklist-create-dialog__input-name").type(name);
      cy.get(".tasklist-create-dialog__input-description").type(description);
      cy.get(".tasklist-create-dialog__select-frequencetype").click();
      cy.get(".mat-option-ripple").then((response) => response[0].click()); // Select first option (daily)

      // submit tasklist
      cy.get(".tasklist-create-dialog__button-create").click();

      // check if task was added to list
      cy.get(".tasklist-list__title").should("contain", name);
    });
  });

  describe("When data is invalid (frequencetype not selected)", () => {
    it("creates TaskList ", () => {
      const errorName = "errorName";
      cy.get(".tasklist-create__button").click();
      // cy.visit(tasklistsUrl);
      console.log(cy.get(".tasklist-create__button"));
      // click to open create task dialog
      // fill data
      cy.get(".tasklist-create-dialog__input-name").type(errorName);
      cy.get(".tasklist-create-dialog__input-description").type(description);

      // submit tasklist
      cy.get(".tasklist-create-dialog__button-create").click();

      // check if task was added to list
      cy.get(".tasklist-list__title").should("not.contain", errorName);
    });
  });
});
