import { TaskItem } from './task_item';
export class Tasklist {
  id: number;
  name: string;
  description: string;
  frequenceType: string;
  taskItems: TaskItem[];

  constructor(tasklist) {
    this.id = tasklist.id;
    this.name = tasklist.name;
    this.description = tasklist.description;
    this.frequenceType = tasklist.frequence_type;
    this.taskItems = tasklist.task_in_lists.map(
      (taskItem: any) => new TaskItem(taskItem, this)
    );
  }
}
