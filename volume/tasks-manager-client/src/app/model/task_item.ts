import { Tasklist } from 'src/app/model/tasklist';
import { Task } from './task';

export class TaskItem {
  id: number;
  task: Task;
  tasklist: Tasklist;
  isChecked: boolean;

  constructor(taskItem, tasklist: Tasklist) {
    this.id = taskItem.id;
    this.isChecked = taskItem.is_checked || false;
    this.task = taskItem.task;
    this.tasklist = tasklist;
  }

  public name(): string {
    return this.task.name;
  }

  public description(): string {
    return this.task.description;
  }
}
