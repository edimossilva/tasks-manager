import { TaskItem } from 'src/app/model/task_item';
import { Component, Inject } from '@angular/core';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { ApiService } from 'src/app/shared/services/api/api.service';
import { HttpErrorResponse } from '@angular/common/http';

@Component({
  selector: 'task-item-delete',
  templateUrl: 'task-item-delete.component.html',
})
export class TaskItemDeleteComponent {
  constructor(
    private api: ApiService,
    public dialogRef: MatDialogRef<TaskItemDeleteComponent>,
    @Inject(MAT_DIALOG_DATA) public data: TaskItem
  ) {}

  onNoClick(): void {
    this.dialogRef.close();
  }

  handleSuccess(response): void {
    console.log(response);
  }

  handleFail(error: HttpErrorResponse): void {
    console.log(error.error.error_message);
  }
  onYesClick(): void {
    this.api
      .deleteTaskItem(this.data.id)
      .subscribe(this.handleSuccess, this.handleFail);
    this.dialogRef.close();
  }
}
