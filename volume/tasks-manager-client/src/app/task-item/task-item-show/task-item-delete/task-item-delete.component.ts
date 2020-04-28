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
    this.dialogRef.close({ delete: true });
  }

  handleFail(error: HttpErrorResponse): void {
    console.error(error.error.error_message);
    this.dialogRef.close({ error: true });
  }

  onYesClick(): void {
    this.api.deleteTaskItem(this.data.id).subscribe(
      (response) => this.handleSuccess(response),
      (error) => this.handleFail(error)
    );
  }
}
