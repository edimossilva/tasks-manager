import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { TasklistCreateComponent } from './tasklist-create.component';

describe('TasklistCreateComponent', () => {
  let component: TasklistCreateComponent;
  let fixture: ComponentFixture<TasklistCreateComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ TasklistCreateComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(TasklistCreateComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
