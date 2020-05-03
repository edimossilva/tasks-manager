/// <reference types="cypress" />

context("Create TaskItem", () => {
  const date = Date.now();
  const description = `description ${date}`;

  beforeEach(() => {
    cy.login();
  });

  describe("When name is valid click create", () => {
    describe("when click create", () => {
      it("creates TaskItem", () => {
        const date = Date.now();
        const taskListName = `taskListName ${date}`;
        const taskItemName = `taskItemName ${date}`;

        cy.createTaskList(taskListName);

        // click on title to open container
        cy.contains(taskListName).then((response) => response[0].click());

        // click on create button to open task item dialog
        cy.get(".task-item-create__button").then((response) =>
          response[0].click()
        );

        // fill data
        cy.get(".task-item-create-dialog__input-name").type(taskItemName);

        // click create button on dialog to create taskitem
        cy.get(".task-item-create-dialog__button-create").then((response) =>
          response[0].click()
        );

        // check if taskitem is present
        cy.get(".task-item-show__checkbox-checked").should(
          "contain",
          taskItemName
        );
      });
    });

    describe("when click cancel", () => {
      it("does not create TaskItem", () => {
        const date = Date.now();
        const taskListName = `taskListName ${date}`;
        const taskItemName = `taskItemName ${date}`;

        cy.createTaskList(taskListName);

        // click on title to open container
        cy.contains(taskListName).then((response) => response[0].click());

        // click on create button to open task item dialog
        cy.get(".task-item-create__button").then((response) =>
          response[0].click()
        );

        // fill data
        cy.get(".task-item-create-dialog__input-name").type(taskItemName);

        // click cancel button on dialog to create taskitem
        cy.get(".task-item-create-dialog__button-cancel").then((response) =>
          response[0].click()
        );

        // check if taskitem is not present
        cy.get(".task-item-show__checkbox-checked").should(
          "not.contain",
          taskItemName
        );
      });
    });
  });
});
