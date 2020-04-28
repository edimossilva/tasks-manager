import { TaskItem } from 'src/app/model/task_item';
import { Component, Inject } from '@angular/core';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';

@Component({
  selector: 'task-item-delete',
  templateUrl: 'task-item-delete.component.html',
})
export class TaskItemDeleteComponent {
  constructor(
    public dialogRef: MatDialogRef<TaskItemDeleteComponent>,
    @Inject(MAT_DIALOG_DATA) public data: TaskItem
  ) {}

  onNoClick(): void {
    this.dialogRef.close();
  }
  onYesClick(): void {
    console.log('yes');
    this.dialogRef.close();
  }
}
