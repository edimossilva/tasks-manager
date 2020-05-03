/// <reference types="cypress" />

context("Create TaskList", () => {
  const date = Date.now();
  const name = `name ${date}`;
  const description = `description ${date}`;

  beforeEach(() => {
    cy.login();
  });

  describe("When data is valid", () => {
    it("creates TaskList ", () => {
      // click to open create task dialog
      cy.get(".tasklist-create__button").click();
      // fill data
      cy.get(".tasklist-create-dialog__input-name").type(name);
      cy.get(".tasklist-create-dialog__input-description").type(description);
      cy.get(".tasklist-create-dialog__select-frequencetype").click();
      cy.clickButton(".mat-option-ripple"); // Select first option (daily)

      // submit tasklist
      cy.get(".tasklist-create-dialog__button-create").click();

      // check if task was added to list
      cy.get(".tasklist-list__title").should("contain", name);
    });
  });

  describe("When data is invalid (frequencetype not selected)", () => {
    it("does not create TaskList ", () => {
      const errorName = "errorName";
      // click to open create task dialog
      cy.clickButton(".tasklist-create__button");
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
