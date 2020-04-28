import { Component, Inject } from '@angular/core';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';

export interface DialogData {
  animal: string;
  name: string;
}
@Component({
  selector: 'task-item-delete',
  templateUrl: 'task-item-delete.component.html',
})
export class TaskItemDeleteComponent {
  constructor(
    public dialogRef: MatDialogRef<TaskItemDeleteComponent>,
    @Inject(MAT_DIALOG_DATA) public data: DialogData
  ) {}

  onNoClick(): void {
    this.dialogRef.close();
  }
}
