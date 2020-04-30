import { Tasklist } from 'src/app/model/tasklist';
import { Task } from './task';

export class TaskItem {
  id: number;
  task: Task;
  tasklist: Tasklist;
  isChecked: boolean;

  constructor(taskItem, tasklist: Tasklist) {
    this.id = taskItem.id;
    this.isChecked = taskItem.checked || false;
    this.task = taskItem.task;
    this.tasklist = tasklist;
  }

  public name(): string {
    return this.task.name;
  }

  public description(): string {
    return this.task.description;
  }

  removeFromTaskList() {
    const index = this.tasklist.taskItems.indexOf(this, 0);
    if (index > -1) {
      this.tasklist.taskItems.splice(index, 1);
    } else {
      console.error(`${this} not found`);
    }
  }
}
