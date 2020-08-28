import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { CertifierDetailsComponent } from './certifier-details.component';

describe('CertifierDetailsComponent', () => {
  let component: CertifierDetailsComponent;
  let fixture: ComponentFixture<CertifierDetailsComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ CertifierDetailsComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(CertifierDetailsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
