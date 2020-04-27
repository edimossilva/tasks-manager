import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { TasklistShowComponent } from './tasklist-show.component';

describe('TasklistShowComponent', () => {
  let component: TasklistShowComponent;
  let fixture: ComponentFixture<TasklistShowComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ TasklistShowComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(TasklistShowComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
