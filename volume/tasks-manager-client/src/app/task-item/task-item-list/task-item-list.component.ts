import { TaskItem } from '../../model/task_item';
import { Component, OnInit, Input } from '@angular/core';

@Component({
  selector: 'app-task-item-list',
  templateUrl: './task-item-list.component.html',
  styleUrls: ['./task-item-list.component.css'],
})
export class TaskItemListComponent implements OnInit {
  constructor() {}

  @Input() taskItems: TaskItem[];
  ngOnInit(): void {}
}
