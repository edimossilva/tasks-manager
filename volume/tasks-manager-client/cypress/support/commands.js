Cypress.Commands.add("login", () => {
  cy.visit("/");
  cy.get(".login__input-username").clear();
  cy.get(".login__input-password").clear();
  cy.get(".login__input-username").type("registered_user2");
  cy.get(".login__input-password").type("222");
  cy.get(".login__button-login").click();
});

Cypress.Commands.add("createTaskList", (name) => {
  // cy.visit("/tasklists");
  cy.get(".tasklist-create__button").click();
  cy.get(".tasklist-create-dialog__input-name").type(name);
  cy.get(".tasklist-create-dialog__input-description").type(
    `description ${name}`
  );
  cy.get(".tasklist-create-dialog__select-frequencetype").click();
  cy.get(".mat-option-ripple").then((response) => response[0].click());

  cy.get(".tasklist-create-dialog__button-create").click();
});
