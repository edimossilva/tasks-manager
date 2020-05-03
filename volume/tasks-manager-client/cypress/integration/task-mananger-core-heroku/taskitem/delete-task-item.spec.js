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

      cy.get(".task-item-show__button_delete").then((response) =>
        response[0].click()
      );

      cy.get(".task-item-delete__button_yes").then((response) =>
        response[0].click()
      );

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

      cy.get(".task-item-show__button_delete").then((response) =>
        response[0].click()
      );

      cy.get(".task-item-delete__button_no").then((response) =>
        response[0].click()
      );

      cy.wait(2000);

      // cy.contains(taskItemName).then((response) =>
      //   expect(response.length).to.equal(1)
      // );
      // cy.get(".task-item-show__checkbox-checked").should(
      //   "not.contain",
      //   taskItemName
      // );
      cy.get(".task-item-show__checkbox-checked").should(
        "contain",
        taskItemName
      );
    });
  });
});
