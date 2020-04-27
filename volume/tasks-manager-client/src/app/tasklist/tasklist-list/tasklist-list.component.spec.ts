import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { TasklistListComponent } from './tasklist-list.component';

describe('TasklistListComponent', () => {
  let component: TasklistListComponent;
  let fixture: ComponentFixture<TasklistListComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ TasklistListComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(TasklistListComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
