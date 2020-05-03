/// <reference types="cypress" />

context("Clean data", () => {
  it("clean test data", () => {
    // cy.request("http://localhost:3000/clean_test_data");
    cy.request(
      "https://edimossilva-task-manager.herokuapp.com/clean_test_data"
    );
  });
});
