import { TaskItem } from '../model/task_item';
import { Component, OnInit, Input } from '@angular/core';

@Component({
  selector: 'app-task-item-show',
  templateUrl: './task-item-show.component.html',
  styleUrls: ['./task-item-show.component.css'],
})
export class TaskItemShowComponent implements OnInit {
  @Input() taskItem: TaskItem;

  constructor() {}

  ngOnInit(): void {}
}
