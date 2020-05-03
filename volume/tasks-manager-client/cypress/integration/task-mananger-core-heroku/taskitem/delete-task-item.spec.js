/// <reference types="cypress" />

context("Delete TaskItem", () => {
  const date = Date.now();
  const description = `description ${date}`;

  beforeEach(() => {
    cy.login();
  });

  describe("when click delete and confirm", () => {
    it("delete TaskItem", () => {
      const date = Date.now();
      const taskListName = `taskListName ${date}`;
      const taskItemName = `taskItemName ${date}`;

      cy.createTaskitem(taskListName, taskItemName);

      cy.clickButton(".task-item-show__button_delete");

      cy.clickButton(".task-item-delete__button_yes");
      cy.wait(2000);

      cy.get(".task-item-show__checkbox-checked").should(
        "not.contain",
        taskItemName
      );
    });
  });

  describe("when click delete and does not confirm", () => {
    it("does not delete TaskItem", () => {
      const date = Date.now();
      const taskListName = `taskListName ${date}`;
      const taskItemName = `taskItemName ${date}`;

      cy.createTaskitem(taskListName, taskItemName);

      cy.clickButton(".task-item-show__button_delete");

      cy.clickButton(".task-item-delete__button_no");

      cy.wait(2000);

      cy.get(".task-item-show__checkbox-checked").should(
        "contain",
        taskItemName
      );
    });
  });
});
