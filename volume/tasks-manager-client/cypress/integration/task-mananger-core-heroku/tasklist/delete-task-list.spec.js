/// <reference types="cypress" />

context("Delete TaskList", () => {
  beforeEach(() => {
    cy.login();
    cy.wait(1000);
  });

  describe("When user click delete", () => {
    it("delete TaskList ", () => {
      const name = `name delete TaskList${Date.now()}`;
      cy.createTaskList(name);
      // click to open create task dialog
      cy.contains(name).then((response) => response[0].click());

      cy.clickButton(".tasklist-list__delete-button");

      cy.wait(2000);

      cy.get(".tasklist-list__title").should("not.contain", name);
    });
  });

  describe("When user click title again", () => {
    it("does not delete TaskList ", () => {
      const name = `name2 delete TaskList${Date.now()}`;
      cy.createTaskList(name);

      // click to open create task dialog
      cy.contains(name).then((response) => response[0].click());

      // click to close create task dialog
      cy.contains(name).then((response) => response[0].click());

      cy.wait(2000);

      cy.get(".tasklist-list__title").should("contain", name);
    });
  });
});
