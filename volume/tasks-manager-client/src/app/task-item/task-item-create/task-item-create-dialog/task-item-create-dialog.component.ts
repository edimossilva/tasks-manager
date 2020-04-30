import { Component, OnInit, Inject } from '@angular/core';
import { ApiService } from 'src/app/shared/services/api/api.service';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { TaskItem } from 'src/app/model/task_item';

@Component({
  selector: 'app-task-item-create-dialog',
  templateUrl: './task-item-create-dialog.component.html',
  styleUrls: ['./task-item-create-dialog.component.css'],
})
export class TaskItemCreateDialogComponent implements OnInit {
  constructor(
    private api: ApiService,
    public dialogRef: MatDialogRef<TaskItemCreateDialogComponent>,
    @Inject(MAT_DIALOG_DATA) public data: TaskItem
  ) {}

  ngOnInit(): void {}
}
